From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 30 Jun 2010 13:36:16 -0700
Subject: [PATCH 02/33] Removing dead ARCH_DAVINCI_TNETV107X
In-Reply-To: <88ee583babc6f0aecb2238a57644f64159d5c395.1277911346.git.siccegge@cs.fau.de>
	(Christoph Egger's message of "Wed, 30 Jun 2010 18:05:38 +0200")
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<88ee583babc6f0aecb2238a57644f64159d5c395.1277911346.git.siccegge@cs.fau.de>
Message-ID: <87vd90jm0v.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoph Egger <siccegge@cs.fau.de> writes:

> ARCH_DAVINCI_TNETV107X doesn't exist in Kconfig, therefore removing
> all references for it from the source code.
>
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

Please leave this define in.

The full support for this platform is currently in linux-next and will
be merged for 2.6.36.

Kevin
