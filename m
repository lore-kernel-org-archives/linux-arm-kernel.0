From: shijie8@gmail.com (Huang Shijie)
Date: Sun, 3 Nov 2013 17:59:05 -0500
Subject: [PATCH v2 11/27] mtd: nand: pxa3xx: Disable OOB on arbitrary
 length commands
In-Reply-To: <1382137374-21251-12-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382137374-21251-12-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131103225903.GE5896@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 08:02:38PM -0300, Ezequiel Garcia wrote:
> READID, STATUS and PARAM (aka ONFI read paramater page) don't read
> the OOB area. Set the oob_size to zero and prevent it.
The ERASE, RESET also donot need to read the OOB,
   why not zero the oob_size for these commands?

  thanks
 Huang Shiji 
