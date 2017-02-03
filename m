From: joe@perches.com (Joe Perches)
Date: Fri, 03 Feb 2017 09:27:38 -0800
Subject: [PATCH] staging: bcm2835-audio: fix spacing of macro
In-Reply-To: <20170203161733.5930-1-hendrik@consetetur.de>
References: <20170203161733.5930-1-hendrik@consetetur.de>
Message-ID: <1486142858.22276.63.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-02-03 at 17:17 +0100, Hendrik v. Raven wrote:
> VC_AUDIO_MAX_MSG_LEN

This macro seems unused and might as well be removed.
