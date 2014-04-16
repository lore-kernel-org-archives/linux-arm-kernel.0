From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Apr 2014 23:28:33 +0200
Subject: [PATCH v2 1/4] memory: mvebu-devbus: fix the conversion of the
 bus width
In-Reply-To: <20140416210924.GL28159@titan.lakedaemon.net>
References: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397489361-5833-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140416210924.GL28159@titan.lakedaemon.net>
Message-ID: <20140416232833.158ef777@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Wed, 16 Apr 2014 17:09:24 -0400, Jason Cooper wrote:

> This looks strikingly similar to patch 4/29 of your own orion5x DT
> conversion series, but with completely different code...  Which one
> would you prefer I take?

Clearly this one. The one in the Orion patch series was a previous
version of this patch, which was not doing any validation on the bus
width value coming from the DT. Once this version is merged somewhere,
I'll base my Orion patch series on it (I'm planning on resending a new
version of my Orion series soon, to take into account all the review
comments I've received).

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
