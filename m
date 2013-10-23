From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 20:56:04 +0200
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <1382547916.8522.42.camel@shinybook.infradead.org>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <1382544332.8522.40.camel@shinybook.infradead.org>
 <20131023165512.GB22394@roeck-us.net>
 <1382547916.8522.42.camel@shinybook.infradead.org>
Message-ID: <20131023185603.GB7863@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 06:05:16PM +0100, David Woodhouse wrote:
> On Wed, 2013-10-23 at 09:55 -0700, Guenter Roeck wrote:
> > 
> > So to avoid tainting the kernel and clogging the kernel log I'll have
> > to remove all the "!" from the dt sources, or not use any "!" in the
> > dt bindings in the first place. Given that, not sure if anyone will
> > really use this mechanism. And CONFIG_OF_EXPERIMENTAL/CONFIG_UNSTABLE_DT
> > might have the same ultimate fate as CONFIG_EXPERIMENTAL.
> 
> It's not as if it's hard for you to patch out the check if you really
> want to do that. This is about making it clear to people what they
> should expect if they use staging code/bindings. 

I agree. The kernel is open source, so people are free to patch it in
any way they want. The best we can do is to come up with a good solution
in an upstream kernel. But there's no way we can control things beyond
that, and we don't have to.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/d46e88e1/attachment.sig>
