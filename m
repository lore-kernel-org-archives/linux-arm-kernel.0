From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 28 May 2014 06:16:45 -0700
Subject: [PATCH v5 0/5] efuse driver for Tegra
In-Reply-To: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
References: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20140528061645.252c2fbc.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 May 2014 15:54:32 +0300 Peter De Schrijver <pdeschrijver@nvidia.com> wrote:

> This driver allows userspace to read the raw efuse data.

The patchset uses an inexplicable mixture of "fuse" and "efuse".
Given that the kernel already has a "fuse", it would be nice if
this code could use "efuse" everywhere.
