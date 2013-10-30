From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 29 Oct 2013 17:40:59 -0700
Subject: [PATCH 2/2] dma: mv_xor: Use high_base mmio where appropriate
In-Reply-To: <20131030003317.GD2527@localhost>
References: <1383000855-8377-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383000855-8377-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAPcyv4iQVoYCXz16T3N4MbdVJV7MoKKeL0wq9t9WF1Kf3gz3Bw@mail.gmail.com>
 <20131029083407.GA2416@localhost> <20131029103229.5e095a24@skate>
 <CAPcyv4iRawGxPwcPhyKCHG+2orVNmPktObR7_TSXwN+6tZ=qog@mail.gmail.com>
 <20131030003317.GD2527@localhost>
Message-ID: <CAPcyv4gMCSBeQbT6tCoJPLwXLe36iOCtL+HLhhzvA1=S_qBoYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 5:33 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> By the way, I didn't initially Cced dmaengine list because it's not
> in the MAINTAINERS file.
>
> How about we add it and avoid this happening to other developers?

It's there now, but we just created it so you happened to be one of
the first ones through...

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n2728

--
Dan
