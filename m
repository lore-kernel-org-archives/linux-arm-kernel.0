From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Apr 2012 11:27:29 +0200
Subject: [PATCH V4 1/5] of: Implement managed of_iomap()
In-Reply-To: <6a0872f9d8959bc9d66d179e4911d6f09a219b42.1334548272.git.viresh.kumar@st.com>
References: <cover.1334548272.git.viresh.kumar@st.com>
 <6a0872f9d8959bc9d66d179e4911d6f09a219b42.1334548272.git.viresh.kumar@st.com>
Message-ID: <CACRpkdbLM8-3qVU7r8XiaHYKZtYDKPRT1tAoKCsJmGBq7+XoLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 6:13 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> This simplifies cleanup paths of user code by providing managed version of
> of_iomap().
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Let's CC Rob Herring on this too in order not to overload Grant...

Yours,
Linus Walleij
