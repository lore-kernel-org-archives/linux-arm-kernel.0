From: timur@tabi.org (Timur Tabi)
Date: Wed, 31 Jul 2013 19:02:12 -0500
Subject: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to
 architecture independent macro
In-Reply-To: <1375187900-17582-3-git-send-email-B44344@freescale.com>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <1375187900-17582-3-git-send-email-B44344@freescale.com>
Message-ID: <CAOZdJXW8uF_e2nQr3gAiMf4E5pvsH_S-ztAXvx9R7-nXyaZGag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 7:38 AM, Arpit Goel <B44344@freescale.com> wrote:
>
> +#ifndef spin_event_timeout
> +/**


Why don't you make PowerPC also use this generic version?  It seems
silly to have two virtually identical implementations of this macro?
