From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 23 Nov 2011 11:10:09 -0200
Subject: [PATCH v2 2/2] MEM2MEM: Add support for eMMa-PrP mem2mem
 operations.
In-Reply-To: <1321963316-9058-3-git-send-email-javier.martin@vista-silicon.com>
References: <1321963316-9058-1-git-send-email-javier.martin@vista-silicon.com>
 <1321963316-9058-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <CAOMZO5Bt-_VGYEZ7a=iaThdxoQb2gpo5Wa1ydUobLLUBVEPRWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 10:01 AM, Javier Martin
<javier.martin@vista-silicon.com> wrote:

> +/* In bytes, per queue */
> +#define MEM2MEM_VID_MEM_LIMIT ?(16 * SZ_1M)

You could use SZ_16M instead.

Regards,

Fabio Estevam
