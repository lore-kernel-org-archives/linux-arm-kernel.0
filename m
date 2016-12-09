From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 9 Dec 2016 12:07:41 +0200
Subject: [PATCH v6 1/5] [media] davinci: VPIF: fix module loading, init
 errors
In-Reply-To: <20161207183025.20684-2-khilman@baylibre.com>
References: <20161207183025.20684-1-khilman@baylibre.com>
 <20161207183025.20684-2-khilman@baylibre.com>
Message-ID: <20161209100741.GL16630@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 10:30:21AM -0800, Kevin Hilman wrote:
> Fix problems with automatic module loading by adding MODULE_ALIAS.  Also
> fix various load-time errors cause by incorrect or not present
> platform_data.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
