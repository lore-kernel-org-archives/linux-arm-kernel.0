From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 Aug 2012 14:53:26 -0700
Subject: [PATCH 2/5] Documentation: add description of DT binding for the
 gpio-mvebu driver
In-Reply-To: <1344691906-15985-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1344691906-15985-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120827215133.GA7431@lumpy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Aug 11, 2012 at 03:31:43PM +0200, Thomas Petazzoni wrote:
> +- gpio-controller: marks the device node as a gpio controller
> +
> +- ngpios: number of GPIOs this controller has
> +
> +- #gpio-cells: Should be one. It is the pin number.

Most platforms will hit a need to encode polarity of the GPIO, in
particular on inputs. Having an extra cell for flags is quite useful.
