From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 18 Oct 2017 10:09:17 +0800
Subject: [PATCH v3] cpufreq: imx6q: Move speed grading check to cpufreq
 driver
In-Reply-To: <CAOMZO5DTtE12znCVbA1YG=1ugggn1fqfbsuCXnkFTwV8b=yNEg@mail.gmail.com>
References: <1506784606-2064-1-git-send-email-festevam@gmail.com>
 <20171013065141.GI8833@dragon>
 <CAOMZO5AwB_2Nbky1wA8neU2-2-LDCTCMFOKGQk4jn5O9zuwKpQ@mail.gmail.com>
 <5060748.qBWaaqo0sL@aspire.rjw.lan>
 <CAOMZO5DTtE12znCVbA1YG=1ugggn1fqfbsuCXnkFTwV8b=yNEg@mail.gmail.com>
Message-ID: <20171018020916.GB18810@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 08:46:10AM -0200, Fabio Estevam wrote:
> On Sun, Oct 15, 2017 at 10:13 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > It could go in via the PM tree (which covers cpufreq), but I'd prefer
> > it to go in via arm-soc.
> 
> Sounds good for me. In this case I think Shawn will apply it.

Okay, applied to imx/soc branch, thanks.

Shawn
