From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 14 May 2014 09:20:13 +0530
Subject: [PATCH v4 2/8] clk: samsung: change scope of samsung clock lock
 to global
In-Reply-To: <1400029876-5830-3-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-3-git-send-email-thomas.ab@samsung.com>
Message-ID: <CAKohpo=J0wbddjn=igwJQNsNQjoddu9A9ApUhuW8Du=6_E=-KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2014 06:41, Thomas Abraham <ta.omasab@gmail.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> Access to samsung clock lock is required to support newer samsung specific
> clock types. So change the scope of the samsung clock lock to global. And

Maybe bit more detail on why exactly it should be available outside this file.
