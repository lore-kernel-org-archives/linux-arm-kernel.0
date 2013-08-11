From: broonie@kernel.org (Mark Brown)
Date: Sun, 11 Aug 2013 12:05:40 +0100
Subject: [alsa-devel] [PATCH 1/3] ASoC: bt-sco: enable OF support
In-Reply-To: <CAGsJ_4y1JoPtXinAvaohDQF_4+DizNYh1jy+iYymypgeZfapKA@mail.gmail.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
 <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
 <20130806170430.GL6427@sirena.org.uk>
 <CAGsJ_4xhkdNTKr6KBPMMPVfi7+NP+WHq2+_V545An6J+c6E7ug@mail.gmail.com>
 <20130807144628.GC6427@sirena.org.uk>
 <CAGsJ_4y1JoPtXinAvaohDQF_4+DizNYh1jy+iYymypgeZfapKA@mail.gmail.com>
Message-ID: <20130811110540.GW6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 04:41:57PM +0800, Barry Song wrote:

> it is fine. but it seems we are not easy to achieve this goal as we
> actually want to do that at uart or tty core instead of specific uart
> driver instance.

Yes, this is one of the problems with DT - it forces things to be solved
in a full and complete fashion since it defines ABI.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130811/cd7a9959/attachment.sig>
