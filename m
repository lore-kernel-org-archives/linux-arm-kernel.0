From: slapin@ossfans.org (Sergey Lapin)
Date: Fri, 20 Jan 2012 06:49:02 -0500
Subject: [PATCH] S3C24XX DMA resume regression fix
In-Reply-To: <4F11F911.7030609@ru.mvista.com>
References: <1326462444-10567-1-git-send-email-dron0gus@gmail.com>
 <4F11F911.7030609@ru.mvista.com>
Message-ID: <20120120114902.GB22732@build.ihdev.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 15, 2012 at 01:52:17AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 13-01-2012 17:47, Gusakov Andrey wrote:
> 
> >In commit bb072c3cf21d1c9a5a2eeb5a00679ee7bf39675b suspend/resume
> 
>    Please also specify that commit's summary in parens.

Could you please point me in direction of patch submission
guide where that is explained.

The commit message summary is
ARM / Samsung: Use struct syscore_ops for "core" power management

But that is not revert of that commit, so I don't really
see a point. This is bug fix which fixes resume code path.

Thanks a lot,
S.
