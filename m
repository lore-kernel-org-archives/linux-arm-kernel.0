From: khilman@baylibre.com (Kevin Hilman)
Date: Sat, 14 May 2016 16:45:23 +0200
Subject: [RFC PATCH 2/3] dt-bindings: reset: Add bindings for the Meson
 GXBB Reset Controller
In-Reply-To: <1463148012-25988-3-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Fri, 13 May 2016 16:00:11 +0200")
References: <1463148012-25988-1-git-send-email-narmstrong@baylibre.com>
 <1463148012-25988-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2vb2g1yws.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add DT bindings for the Meson GXBB SoC Reset Controller documentation and the
> associated include file.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[...]

> +#define RESET_Ethernet		19

nit: all the others are all uppercase.  This should be as well for
consistency.

Kevin
