From: olof@lixom.net (Olof Johansson)
Date: Mon, 30 Jan 2012 20:53:44 -0800
Subject: [PATCH v3 00/25] irq_domain generalization and refinement
In-Reply-To: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
Message-ID: <20120131045344.GA27609@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 02:35:54PM -0700, Grant Likely wrote:
> Hey everyone,
> 
> This patch series is ready for much wider consumption now.  I'd like
> to get it into linux-next ASAP because there will be ARM board support
> depending on it.  I'll wait a few days before I ask Stephen to pull
> this in.
> 
> Stephen/Milton/Ben, any testing you can help with here would be
> appreciated since you've got access to a wider variety of Power
> machines than I do.

This series has been:

Tested-by: Olof Johansson <olof@lixom.net>

On powerpc/pasemi (it's the only one I still have easy access to).


-Olof
