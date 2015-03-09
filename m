From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 9 Mar 2015 15:47:00 +0100
Subject: [PATCH v2 3/5] arm: KVM: add a common vgic_queue_irq_to_lr fn
In-Reply-To: <1425302944-6276-4-git-send-email-alex.bennee@linaro.org>
References: <1425302944-6276-1-git-send-email-alex.bennee@linaro.org>
 <1425302944-6276-4-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150309144700.GE20559@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 01:29:02PM +0000, Alex Benn?e wrote:
> This helps re-factor away some of the repetitive code and makes the code
> flow more nicely.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> 
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
