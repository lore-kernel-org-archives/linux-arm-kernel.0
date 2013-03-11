From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 11 Mar 2013 15:53:31 +0530
Subject: [PATCH] watchdog: convert to devm_ioremap_resource()
In-Reply-To: <1362987503-6449-1-git-send-email-silviupopescu1990@gmail.com>
References: <1362987503-6449-1-git-send-email-silviupopescu1990@gmail.com>
Message-ID: <CAK9yfHxJNtdYdx4pwfq_F2HBvOxvumt+XFsdQQjh2xHB9_s3sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11 March 2013 13:08, Silviu-Mihai Popescu
<silviupopescu1990@gmail.com> wrote:
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
>
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.
>
> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>

I have already submitted a similar patchset to do this:
http://www.spinics.net/lists/linux-watchdog/msg02101.html


-- 
With warm regards,
Sachin
