From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 7 Feb 2013 16:50:09 +0530
Subject: [PATCH 1/3] cpufreq: exynos: Remove error return even if no soc
 found
In-Reply-To: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <CAOh2x=nAaVNZG-Dfe0v-Uy4zRxf+zmPhxGx+=1rC=cT787=Vbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 1:09 AM, Amit Daniel Kachhap
<amit.daniel@samsung.com> wrote:
> This change is needed for adding different type of cpufreq driver
> and support single binary image.

That's not sufficient, we need more description of the problem you faced.
