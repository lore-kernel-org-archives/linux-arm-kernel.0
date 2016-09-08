From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 8 Sep 2016 09:44:44 +0200
Subject: [RFC PATCH 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <CAFcVECJxJgJUeO4=yudwTj5NkxDob5tCZaom9YTqWWmtt7ajFw@mail.gmail.com>
References: <1472820817-21874-1-git-send-email-andrei.pistirica@microchip.com>
 <20160906154809.GA7012@localhost.localdomain>
 <CAFcVECJxJgJUeO4=yudwTj5NkxDob5tCZaom9YTqWWmtt7ajFw@mail.gmail.com>
Message-ID: <20160908074444.GA3341@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 10:22:43AM +0530, Harini Katakam wrote:
> I cant be sure of the version of Cadence GEM used in SAMA5D2
> but these registers (sub ns increments alteast) only exist in
> the IP version used in Zynq Ultrascale+ MPSoC.

Then you need to find a way to make sure the driver only binds to the
correct silicon.

Thanks,
Richard
