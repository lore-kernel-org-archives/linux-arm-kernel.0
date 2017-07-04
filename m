From: kdinh@apm.com (Khuong Dinh)
Date: Mon,  3 Jul 2017 18:07:29 -0600
Subject: [PATCH] arm64: use readq() instead of readl() to read 64bit
 entry_point
In-Reply-To: <20170626131625.79059-1-luc.vanoostenryck@gmail.com>
References: <20170626131625.79059-1-luc.vanoostenryck@gmail.com>
Message-ID: <1499126849-24599-1-git-send-email-kdinh@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is good with X-Gene 1/2.

Tested-by: Khuong Dinh <kdinh@apm.com>
