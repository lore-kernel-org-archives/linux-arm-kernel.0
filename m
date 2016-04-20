From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2016 16:38:23 +0200
Subject: [PATCH 4/8] gpio: stmpe: write int status register only when
 needed
In-Reply-To: <1461068317-28016-5-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <1461068317-28016-5-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdYDgghbVptmev==JfQnBN9Wu9D-rL5UUP5cwvjg8GvxEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 2:18 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> On STMPE801/1801 datasheets, it's mentionned writing
> in interrupt status register has no effect, bits are
> cleared when reading.
>
> Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
