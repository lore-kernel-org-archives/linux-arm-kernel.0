From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 31 Mar 2015 18:33:55 +0100
Subject: [PATCH 3/3] ahci: st: st_configure_oob must be called after IP
 is clocked.
In-Reply-To: <20150331155951.GG9974@htj.duckdns.org>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
 <1427787309-1601-4-git-send-email-peter.griffin@linaro.org>
 <20150331152958.GF9974@htj.duckdns.org>
 <20150331153627.GA8200@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150331155951.GG9974@htj.duckdns.org>
Message-ID: <20150331173355.GA15635@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

On Tue, 31 Mar 2015, Tejun Heo wrote:

> On Tue, Mar 31, 2015 at 04:36:27PM +0100, Peter Griffin wrote:
> > This patch (and also the DT documentation change) can go via your tree. Maxime
> > will take the stih407 DT patch.
> 
> Hmmm... The first patch doesn't apply to libata/for-4.1?

I was just investigating this, and you don't have the patch I sent on 25th February
entitled "ahci: st: Update the DT example for how to obtain the PHY."

I also did a re-send yesterday with ack's collected here https://lkml.org/lkml/2015/3/30/404.

However both times it seems I didn't add you to the email :-( which certainly explains
why you don't have it.

If I re-send that patch with you on CC can you take and apply it as well? That would
preserve the ack's.

regards,

Peter.
