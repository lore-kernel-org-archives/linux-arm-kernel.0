From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 30 Jun 2015 15:20:22 +0200
Subject: [PATCH v3 05/11] KVM: arm: check ordering of all system register
 tables
In-Reply-To: <1434969694-7432-6-git-send-email-zhichao.huang@linaro.org>
References: <1434969694-7432-1-git-send-email-zhichao.huang@linaro.org>
 <1434969694-7432-6-git-send-email-zhichao.huang@linaro.org>
Message-ID: <20150630132022.GU11332@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 06:41:28PM +0800, Zhichao Huang wrote:
> We now have multiple tables for the various system registers
> we trap. Make sure we check the order of all of them, as it is
> critical that we get the order right (been there, done that...).
> 
> Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
