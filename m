From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Oct 2015 13:45:09 -0700
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <201510122225.12786@pali>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <20150713131902.GH26485@atomide.com>
 <20151012201640.GQ23801@atomide.com> <201510122225.12786@pali>
Message-ID: <20151012204509.GT23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [151012 13:29]:
> On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
> > 
> > Pali, any news on posting an updated series with the comments
> > addressed in this thread? It seems that we all pretty much agree
> > what needs to be done.
> 
> Tony, I'm not really sure what to do. Just wrap 4 and 5 patches into 
> CONFIG_KEXEC? Or something more?

Well for most part your patches are fine, I think there were some
minor comments on the series.

For the CONFIG_KEXEC dependency, we should just keep the existing
behavior and keep /proc/atags behind CONFIG_KEXEC. That's all
I believe :)

Regards,

Tony
