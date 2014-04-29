From: dmurphy@ti.com (Dan Murphy)
Date: Tue, 29 Apr 2014 15:19:39 -0500
Subject: [RFC] TI Reset Driver adapted to the reset core
Message-ID: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a RFC on the TI reset adoption to the Reset framework.

The patchset was derived from work from Rajendra Nayak and Afzal Mohammed
who have had similar code offerings.  One of the major differences here
is the SoC data has been broken out so that the data and code are independent.

There is currently no OMAP4 or prior support added to this patch series.
Once the RFC is complete and the code infrastructure looks to be acceptable
I will add these data sets into the patchset.

Dan 
