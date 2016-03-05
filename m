From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 5 Mar 2016 14:19:49 -0800
Subject: [PATCH v2] serial: xuartps: Enable OF earlycon support
In-Reply-To: <56CEFBD7.40008@monstr.eu>
References: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
 <56C5F670.50005@hurleysoftware.com> <56CEFBD7.40008@monstr.eu>
Message-ID: <20160305221949.GA19842@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 02:04:23PM +0100, Michal Simek wrote:
> Hi Greg,
> 
> On 18.2.2016 17:50, Peter Hurley wrote:
> > On 02/17/2016 11:57 PM, Michal Simek wrote:
> >> Support early console setup via DT for all listed compatible strings.
> >> Remove EARLYCON_DECLARE which was done by:
> >> "Use common framework for earlycon declarations"
> >> (sha1: 2eaa790989e03900298ad24f77f1086dbbc1aebd)
> >> when OF_EARLYCON_DECLARE is defined.
> > 
> > Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> 
> Can you please add it your queue for 4.6?
> Or can we merge it via arm-soc tree as was suggested by Arnd here?
> https://lkml.org/lkml/2016/2/16/315

I can take it, thanks.

greg k-h
