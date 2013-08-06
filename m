From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 06 Aug 2013 13:28:12 +0100
Subject: [PATCH 1/3] ARM: vexpress: move spc driver back under
 mach-vexpress
In-Reply-To: <20130806085549.GA18810@e102568-lin.cambridge.arm.com>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <1375675793-16492-2-git-send-email-olof@lixom.net>
 <20130805095235.GB29090@e102568-lin.cambridge.arm.com>
 <20130805232605.GA32172@quad.lixom.net>
 <20130806085549.GA18810@e102568-lin.cambridge.arm.com>
Message-ID: <1375792092.12043.56.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-06 at 09:55 +0100, Lorenzo Pieralisi wrote:
> I just wanted to say that sending a patch to fix the issue was inappropriate
> because it depended on where the spc.h has to be created and did not
> know if Pawel was ok with the idea of moving spc back to mach-vexpress.
> 
> I am ok with your changes, thank you very much.

Although it works against the goal of removing arch/arm/mach-vexpress
completely ;-) I appreciate the fact that there's more than that on the
way, so yeah, it's fine with me.

Cheers!

Pawel

PS. Apologies about the delay and thanks for testing it out, Lorenzo!
