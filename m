From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 May 2013 11:03:42 -0500
Subject: [PATCH v4] ASoC: dfbmcs320: make the driver common for other BT
 modules
In-Reply-To: <CAGsJ_4x3QrvReOnFQFqRMWfUf-v-Js4+L_Vr8jht_wR-ApQJrg@mail.gmail.com>
References: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
 <20130521181849.GG1627@sirena.org.uk>
 <CAGsJ_4x3QrvReOnFQFqRMWfUf-v-Js4+L_Vr8jht_wR-ApQJrg@mail.gmail.com>
Message-ID: <20130522160342.GN1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 01:15:26PM +0800, Barry Song wrote:

> thanks, Mark. can we also do something in omap-hdmi to make the HDMI
> codec common as well?
> i think it is in the same situation with BT SCO:
> http://comments.gmane.org/gmane.linux.alsa.devel/108234

None of the OMAP guys have reviewed that yet and you only sent it last
week.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130522/ef3d811a/attachment.sig>
