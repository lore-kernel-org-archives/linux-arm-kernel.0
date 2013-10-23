From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 23 Oct 2013 18:05:16 +0100
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023165512.GB22394@roeck-us.net>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <1382544332.8522.40.camel@shinybook.infradead.org>
 <20131023165512.GB22394@roeck-us.net>
Message-ID: <1382547916.8522.42.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-23 at 09:55 -0700, Guenter Roeck wrote:
> 
> So to avoid tainting the kernel and clogging the kernel log I'll have
> to remove all the "!" from the dt sources, or not use any "!" in the
> dt bindings in the first place. Given that, not sure if anyone will
> really use this mechanism. And CONFIG_OF_EXPERIMENTAL/CONFIG_UNSTABLE_DT
> might have the same ultimate fate as CONFIG_EXPERIMENTAL.

It's not as if it's hard for you to patch out the check if you really
want to do that. This is about making it clear to people what they
should expect if they use staging code/bindings. 

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/68b4ec33/attachment.bin>
