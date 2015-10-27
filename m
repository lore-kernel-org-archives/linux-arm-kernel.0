From: timur@tabi.org (Timur Tabi)
Date: Tue, 27 Oct 2015 17:54:38 -0500
Subject: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
In-Reply-To: <562E447E.6070703@arm.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org> <562DF96D.6020307@arm.com>
 <562E20B2.4050805@codeaurora.org> <562E3213.8070602@arm.com>
 <562E33AE.2020608@codeaurora.org> <562E3BCF.7010000@arm.com>
 <562E3D02.2040108@codeaurora.org> <562E447E.6070703@arm.com>
Message-ID: <563000AE.4070107@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2015 10:19 AM, Andre Przywara wrote:
>> >We have an internal patch that I'm trying to upstream, but I need the
>> >amba-pl011 driver to stabilize first.

> As mentioned earlier, this looks like the perfect opportunity now to get
> the change in (since I see it as a subset of Jun's series). "Waiting for
> stabilization" sounds a bit optimistic to me in a general Linux context;-)

Unfortunately, I must depend on Leif Lindholm's SPCR patches.  He's 
working on a new version, but until then I can't do much.  They should 
be out soon, though.
