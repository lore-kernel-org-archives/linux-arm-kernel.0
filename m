From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 May 2016 17:25:56 +0100
Subject: [PATCH v2 2/4] Documentation: Add documentation for APM X-Gene
 SoC PMU DTS binding
In-Reply-To: <CACgAJHz8bRb6E1xNFwhKpHDGxPhEsQ3J=H_u3woVLgzK0j==Bg@mail.gmail.com>
References: <1460510547-17611-1-git-send-email-ttnguyen@apm.com>
 <1460510547-17611-3-git-send-email-ttnguyen@apm.com>
 <20160418170009.GA15338@rob-hp-laptop>
 <CACgAJHyBbO_LXwtfNVK1f=dY3v1Jfxwxq1dw98EZ0aYdhjPpAg@mail.gmail.com>
 <20160420113121.GE2514@arm.com>
 <20160502205648.GA7374@rob-hp-laptop>
 <CACgAJHyT31DuVNoyRQZVKjv=zM5Fc-EY0gy=y=pHHrBTT+1Xow@mail.gmail.com>
 <CACgAJHyHEOe70pOG2yi-XUQS3BYdGmfYD-yTE0wFM9knDtHOiQ@mail.gmail.com>
 <CACgAJHz8bRb6E1xNFwhKpHDGxPhEsQ3J=H_u3woVLgzK0j==Bg@mail.gmail.com>
Message-ID: <20160531162555.GQ24936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 02:12:19PM -0700, Tai Tri Nguyen wrote:
> It's been weeks.
> I just want to ping again if you have any more comments on this patch set?

We seem to have reached a stalemate whereby:

  - The devicetree maintainers don't agree with your binding
  - You don't agree with them
  - I won't merge the patch without their ack

so I guess you either need to try harder to convince them about the
index-based binding, or bite the bullet and fix it to make them happy.

Will
