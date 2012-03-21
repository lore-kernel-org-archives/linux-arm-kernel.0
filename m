From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 20 Mar 2012 22:33:07 -0400 (EDT)
Subject: [PATCH 2/2] ARM: pxa: use commom IOMEM definiton
In-Reply-To: <1332296149-28110-2-git-send-email-robherring2@gmail.com>
References: <4F68CD9C.3090001@windriver.com>
 <1332296149-28110-1-git-send-email-robherring2@gmail.com>
 <1332296149-28110-2-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1203202231420.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Mar 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> pxa was missed in the moving of IOMEM to a common defintion, so lots of
> IOMEM redefined warnings were introduced. So remove pxa IOMEM definition
> and fix all the fallout.

You've got at least 3 typos in the above, with 2 of them in the subject 
line alone.  ;-)


Nicolas
