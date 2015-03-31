From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 31 Mar 2015 09:26:47 +0200
Subject: [alsa-devel] [PATCH 1/2] ASoC: cygnus-audio: adding device tree
 bindings
In-Reply-To: <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
Message-ID: <551A4C37.5090903@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2015 05:16 AM, Scott Branden wrote:
[...]
> +- ssp-port-id: The ssp port interface to use
> +	Valid value are 0, 1, 2, or 3 (for spdif)

How about using 'reg' as the property name here. It is the standard property 
name for identifying or assigning an address to a sub-node.
