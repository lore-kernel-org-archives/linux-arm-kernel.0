From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 3 Apr 2018 18:56:45 +0200
Subject: [PATCH v6 3/3] i2c: add param sanity check to i2c_transfer()
In-Reply-To: <20180403150311.7gpvcga33eivlyms@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180325110747.8852-4-ard.biesheuvel@linaro.org>
 <20180403150311.7gpvcga33eivlyms@ninjato>
Message-ID: <CAKv+Gu9LJPxsLjdigBYrOgucxoo9pyE-6vx-PR3zagdD7h0Euw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2018 at 17:03, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +     if (!msgs || num < 1)
>> +             return -EINVAL;
>
> I think this case justifies WARN (or WARN_ON, I always mix them up).
>

OK.
