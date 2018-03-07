From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 10:13:41 -0600
Subject: [PATCH v3 3/3] tty: st-asc: Update tty alias
In-Reply-To: <1520412597-30545-4-git-send-email-patrice.chotard@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
 <1520412597-30545-4-git-send-email-patrice.chotard@st.com>
Message-ID: <CAL_JsqL5bO1MpHvATfRAGi9=cHzBf3n6AVD5=JVfAzt0DnGfqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2018 at 2:49 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
> must include only lowercase and '-'.
>
> After having updated all STi boards serial aliases from "ttyASN"
> to "serialN", st-asc driver need to be updated accordingly as tty
> aliases id is retrieved using of_alias_get_id().
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
> v3: _ update st-asc driver with "serial" alias prefix and keep "ttyAS" in second choice
> v2: _ update st-asc driver with "serial" alias prefix
>
>  drivers/tty/serial/st-asc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
