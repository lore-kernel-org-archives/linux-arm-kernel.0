From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue,  7 Dec 2010 18:23:11 +1100
Subject: [PATCH] Added i2c support for mc13xxx-core
In-Reply-To: <201012070854.21049.marc@cpdesign.com.au>
References: <201012070854.21049.marc@cpdesign.com.au>
Message-ID: <1291706592-6631-1-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch adds i2c support for the mc13892. It should apply over Yong's
earlier patches.
I've kept everything to one file for the moment, and aimed for minimal impact
on Yong's code to hopefully ease initial integration.

Tested basic functionality on iMX35 based platform (with an mc13892)

Cheers,
Marc
