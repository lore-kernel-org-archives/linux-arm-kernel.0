From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 23 Sep 2009 16:26:02 -0700
Subject: [PATCH/RFC] Runtime PM: ARM: subarch-specific extensions of
	pdev_archdata
In-Reply-To: <20090923035411.GD31920@trinity.fluff.org>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<20090923035411.GD31920@trinity.fluff.org>
Message-ID: <4ABAAE8A.8050608@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> How about adding a Kconfig for any architectures interested in defining
> it to declare that they do not want a generic version, or some form of
> default include that could be used to support archs where this is not
> defined?
> 
> This i san awful lot of nothing header addition.
> 

I'm ok with a Kconfig option if that is preferred, but personally I 
prefer minimizing Kconfig space.

Thanks for the comments,

Kevin
