From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jun 2018 09:54:00 -0300
Subject: [PATCH 1/4] clk: imx6q: remove clks_init_on array
In-Reply-To: <2D554312-36F2-4781-899C-8D9F5BD20B46@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CmgBsaaegVV9OjdyXv5_O0V9iTS2qYbtuH26qkG2_zrA@mail.gmail.com>
 <2D554312-36F2-4781-899C-8D9F5BD20B46@nxp.com>
Message-ID: <CAOMZO5ANz-B-s93+R_xnF0LOux1zTY3E8Ky4KvrZ8EX1ZKmpAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Sun, Jun 3, 2018 at 9:48 AM, Anson Huang <anson.huang@nxp.com> wrote:

> As I explain in previous mail, busy divider clk type already include the flag when registered.

Ok, then please add this information in the commit log to make the
review process easier.
