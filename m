From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 16 May 2014 10:52:05 +0900
Subject: [PATCH] clk: shmobile: Add R8A7740-specific clock support
In-Reply-To: <1400156437-19694-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1400156437-19694-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <CANqRtoTq5ri+ye7Htcg3hSRZCUmvyMcuWAXvkcAV8arDjuLYzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulrich,

On Thu, May 15, 2014 at 9:20 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> Driver for the R8A7740's clocks that are too specific to be supported by a
> generic driver.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---

Thanks a lot for your patches. My gut feeling is that r8a7740 CCF
support should be pretty close to be finalized, but I also see some
feedback and I have a bit of hard time following what is going on. My
hope has been to include r8a7740 CCF in v3.16 (this patch), but we may
be running out of time there. What's the latest status?

Would it be possible for you to adjust your work flow to always
include version number of patch and also include a change log?
Basically, I'd like to know which is the latest patch and if all the
issues have been fixed up.

Cheers,

/ magnus
