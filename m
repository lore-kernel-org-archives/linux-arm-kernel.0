From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 4 Jun 2015 11:56:54 +0100
Subject: [PATCH v5 2/6] target-arm: kvm64: introduce kvm_arm_init_debug()
In-Reply-To: <1432912764-7073-3-git-send-email-alex.bennee@linaro.org>
References: <1432912764-7073-1-git-send-email-alex.bennee@linaro.org>
 <1432912764-7073-3-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA8GBDF1=ju9N6uuOK+pFxZ5sJxm0mwBV+OrY3R8YUhJkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2015 at 16:19, Alex Benn?e <alex.bennee@linaro.org> wrote:
> As we haven't always had guest debug support we need to probe for it.
> Additionally we don't do this in the start-up capability code so we
> don't fall over on old kernels.
>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
