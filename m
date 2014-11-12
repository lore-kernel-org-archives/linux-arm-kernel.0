From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 12 Nov 2014 07:57:58 -0800
Subject: [PATCH RESEND] Documentation: devicetree: Fix Xilinx VDMA
 specification
In-Reply-To: <1415800277-6817-1-git-send-email-afaerber@suse.de>
References: <1415800277-6817-1-git-send-email-afaerber@suse.de>
Message-ID: <6067bede14b9421fa87db96bdc66dc66@BN1AFFO11FD040.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-11-12 at 02:51PM +0100, Andreas F?rber wrote:
> The specification requires xlnx,data-width, but example and driver use
> xlnx,datawidth. Change the specification to match the implementation.

Isn't this the wrong way around? The bindings are considered API, so
shouldn't the driver be fixed to match the spec?
Are there already dts files out there using either of these options?

	Soren
