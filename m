From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 23 Oct 2013 20:40:00 +0100
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023185909.GC7863@ulmo.nvidia.com>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
 <20131023185909.GC7863@ulmo.nvidia.com>
Message-ID: <20131023193959.GA6777@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > I'd even go further and use "unstable-" as the prefix instead of "!"
> > which is way more explicit.
> 
> I guess unstable- is as good as anything. I personally think that "!" is
> disturbing enough to the eye to make it abundantly clear that something
> is fishy.

"!" marks the binding as "special" whatever that is. A busy person might
decide to not look that up as long as it works right now. "unstable-"
(or maybe "unstable!-" ;)) is explicit so people know what they get.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/01da0495/attachment.sig>
