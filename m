From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Thu, 19 Dec 2013 13:18:48 +0200
Subject: [PATCH v3 12/21] serial: support for 16550A serial ports on
 LP-8x4x
In-Reply-To: <1387309071-22382-13-git-send-email-ynvich@gmail.com>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-13-git-send-email-ynvich@gmail.com>
Message-ID: <20131219111848.GD20686@xps8300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 17, 2013 at 11:37:42PM +0400, Sergei Ianovich wrote:
> The patch adds support for 3 additional LP-8x4x built-in serial
> ports.
> 
> The device can also host up to 8 extension cards with 4 serial ports
> on each card for a total of 35 ports. However, I don't have
> the hardware to test extension cards, so they are not supported, yet.
> 
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Looks OK to me, though normally I would prefer the arch code and the
driver to be handled in separate patches. FWIW...

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
