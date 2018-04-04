From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 4 Apr 2018 23:01:45 +0200
Subject: [PATCH v7 3/4] i2c: add param sanity check to i2c_transfer()
In-Reply-To: <20180404183823.ejewg6ran5li2vt5@ninjato>
References: <20180403191151.14924-1-ard.biesheuvel@linaro.org>
 <20180403191151.14924-4-ard.biesheuvel@linaro.org>
 <20180404183823.ejewg6ran5li2vt5@ninjato>
Message-ID: <CAKv+Gu95je4RPedd9N0xzNWmgggH1FFhquGkLjxcWT3MoRyasg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2018 at 20:38, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Apr 03, 2018 at 09:11:50PM +0200, Ard Biesheuvel wrote:
>> The API docs describe i2c_transfer() as taking a pointer to an array
>> of i2c_msg containing at least 1 entry, but leaves it to the individual
>> drivers to sanity check the msgs and num parameters. Let's do this in
>> core code instead.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Looks good but I want to test it myself, so I will include it in my
> second pull request later.
>

Thanks Wolfram
