From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 7 Jun 2011 12:22:11 +0300
Subject: [RFC 0/6] iommu: generic api migration and grouping
In-Reply-To: <20110607075221.GB4407@amd.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
	<20110606100950.GC30762@amd.com>
	<BANLkTi=i2s-Ujiy4qn_XQv+9dMjUC9R66A@mail.gmail.com>
	<20110606153557.GE1953@amd.com>
	<BANLkTinwwVO4TmsxuTfSBf6jqYrEVV3b_A@mail.gmail.com>
	<20110606192030.GA4356@amd.com>
	<BANLkTinx21-E3DRe9D7LRB8e1aeOwv=-9A@mail.gmail.com>
	<20110607075221.GB4407@amd.com>
Message-ID: <BANLkTimR3KofKA3LSKXdX8k1FGR0XUxu=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2011 at 10:52 AM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Yup. Btw, is there any IOMMU hardware which supports non-natural
> alignment? In this case we need to expose these requirements somehow.

Not sure there are. Let's start with natural alignment, and extend it
only if someone with additional requirements shows up.
