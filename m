From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 22 Apr 2016 12:17:33 +0530
Subject: [PATCH 5/8] cpufreq: shmobile: Use generic platdev driver
In-Reply-To: <CAMuHMdWXH+Oud+ZZbYFUcTN1a0v9_BJbP5cMLxx0tRWHzx4ADQ@mail.gmail.com>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <ab29df38f70453e67089e3f3dbb9085336eef1c2.1461228081.git.viresh.kumar@linaro.org>
 <CAMuHMdUnzgr==S86Wiz0fGk2gSWW2=j+maiq3=3x9Ozy7AoOZw@mail.gmail.com>
 <20160422032142.GN29799@vireshk-i7>
 <CAMuHMdWXH+Oud+ZZbYFUcTN1a0v9_BJbP5cMLxx0tRWHzx4ADQ@mail.gmail.com>
Message-ID: <20160422064733.GA13716@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-04-16, 08:41, Geert Uytterhoeven wrote:
> I was mainly thinking about kernel size.

Ahh, I see..

> If this is done once per boot, the array should be __initconst,
> (looking at the code
> in next) which is fine as cpufreq_dt_platdev_init() is already __init.

Sure, makes sense.. I will do that as a separate patch.

Though just to correct what I earlier said, if cpufreq-dt is developed as a
module, its done once per module insertion :)

-- 
viresh
