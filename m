From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Aug 2010 15:02:39 +0100
Subject: [PATCH 0/5] ASoc: support 88pm860x codec driver
In-Reply-To: <AANLkTintnm9NYS+cybvgPyNWqBg_=7_tJGG-TBxvsJRc@mail.gmail.com>
References: <AANLkTintnm9NYS+cybvgPyNWqBg_=7_tJGG-TBxvsJRc@mail.gmail.com>
Message-ID: <20100813140238.GC6449@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 09:55:00PM +0800, Haojian Zhuang wrote:

> Add 88pm860x codec driver. This series patch is based on ASoC for-2.6.37 branch.

Hrm, looking at this series much of it is not actually related to the
CODEC - 2/5 patches are bugfixes for the PXA multi-component code, for
example.  No problem with the patches themselves but it's good to be
clearer about what you're doing.
