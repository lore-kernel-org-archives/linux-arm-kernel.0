From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 26 Sep 2014 18:39:35 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <CAOQ7t2Z8SgjMMM_QgUuAgezMXDBYyJM4kez-3WzGE4jgutjX6g@mail.gmail.com>
References: <20140926112344.3ee87d2f@canb.auug.org.au>
 <CAOQ7t2Z8SgjMMM_QgUuAgezMXDBYyJM4kez-3WzGE4jgutjX6g@mail.gmail.com>
Message-ID: <20140926183935.4a4eec89@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Fri, 26 Sep 2014 10:19:43 +0200 Carlo Caione <carlo@caione.org> wrote:
>
> Am I going blind or these two lines are missing from d8a00916b303
> 
> +       default 0xc81004c0 if DEBUG_MESON_UARTAO
> ...
> +       default 0xf31004c0 if DEBUG_MESON_UARTAO

They are in the final version of arch/arm/Kconfig.debug, just not shown
in the conflict resolution above.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/0fd803aa/attachment.sig>
