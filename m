From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 23 Feb 2016 07:32:22 -0800
Subject: [PATCH v4 05/10] serial: mps2-uart: add support for early console
In-Reply-To: <1456238068-25079-6-git-send-email-vladimir.murzin@arm.com>
References: <1456238068-25079-1-git-send-email-vladimir.murzin@arm.com>
 <1456238068-25079-6-git-send-email-vladimir.murzin@arm.com>
Message-ID: <56CC7B86.5020307@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2016 06:34 AM, Vladimir Murzin wrote:
> This adds support early console for MPS2 UART which can be enabled via
> earlycon=mps2,0x40004000

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
