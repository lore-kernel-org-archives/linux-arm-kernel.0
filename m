From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2012 13:11:12 -0300
Subject: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
In-Reply-To: <20120615160635.GP31565@S2101-09.ap.freescale.net>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <1339774557-23588-2-git-send-email-fabio.estevam@freescale.com>
 <20120615160635.GP31565@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 1:06 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

>> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
> ...
>> + ? ? ? ? ? ? .id_table = mxs_auart_devtype,
>
> I do not think we need these.

WIthout this, the non-dt kernel does not probe correctly.
