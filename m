From: ben@trinity.fluff.org (Ben Dooks)
Date: Wed, 23 Sep 2009 04:54:12 +0100
Subject: [PATCH/RFC] Runtime PM: ARM: subarch-specific extensions of
	pdev_archdata
In-Reply-To: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20090923035411.GD31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

How about adding a Kconfig for any architectures interested in defining
it to declare that they do not want a generic version, or some form of
default include that could be used to support archs where this is not
defined?

This i san awful lot of nothing header addition.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
