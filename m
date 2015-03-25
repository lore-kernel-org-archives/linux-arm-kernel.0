From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 25 Mar 2015 21:00:38 +0100
Subject: [PATCH] arm: crypto: Add NEON optimized SHA-256
In-Reply-To: <20150316154835.GA31336@google.com>
References: <20150316154835.GA31336@google.com>
Message-ID: <20150325200038.GM14457@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:48 Mon 16 Mar     , Sami Tolvanen wrote:
> Add Andy Polyakov's NEON optimized SHA-256 implementation.
> 
> On Nexus 6, this implementation is ~2x faster than sha256-generic.

do you plan to add the sha512 from openssl too?

Whould be nice so armv4 can get faster implementatio too

Best Regards,
J.
