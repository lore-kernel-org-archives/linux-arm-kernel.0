From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 21 Jun 2010 15:27:49 +0800
Subject: [PATCH 1/2] [ARM] Introduce 'struct machine_class' for SoC level
	abstraction
In-Reply-To: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
References: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
Message-ID: <201006211527.49786.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> For machine class (mostly equivalent to SoC) level abstraction.

Could you detail your intended usage of machine_class and how this will fit in 
with the mdesc? Will the mdesc fields override the machine_class fields, or is 
this intended to be a replacement?

Cheers,


Jeremy
