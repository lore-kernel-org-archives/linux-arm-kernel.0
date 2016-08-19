From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 19 Aug 2016 15:03:06 -0700
Subject: [PATCH v2 3/3] ARM64: dts: meson-gxbb: Add GXBB AO Clock and
 Reset node
In-Reply-To: <1471514928-3341-4-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 18 Aug 2016 12:08:48 +0200")
References: <1471514928-3341-1-git-send-email-narmstrong@baylibre.com>
 <1471514928-3341-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hk2fc76xx.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add the AO clock controller node for the AmLogic GXBB SoC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

Applying this to the amlogic tree, but will need to wait a cycle due to
include dependencies on the bindings, which are going through the clock
tree.

Kevin
