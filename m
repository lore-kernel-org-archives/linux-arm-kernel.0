From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 19 Jun 2014 21:59:28 -0700
Subject: [PATCH v3 0/3] Qualcomm Resource Power Manager driver
In-Reply-To: <CAJe_ZhcSMrN6OeRjo7cG7CMobjEPMMB7o0eUD9HAFskravSQ3w@mail.gmail.com>
References: <1402944372-31901-1-git-send-email-bjorn.andersson@sonymobile.com>
 <7hvbrzbh1u.fsf@paris.lan>
 <CAJAp7OhHr4Cgcp9pvQ3=MAie_zSnFJxG28Vf37qJ98BK7P1jaQ@mail.gmail.com>
 <7hzjha8b97.fsf@paris.lan>
 <842A7147-A2CC-42BD-9947-CBADF738DC92@codeaurora.org>
 <7hegym6uca.fsf@paris.lan>
 <CAJe_ZhfmsgvnVu-VgN63LaZ-522HuAY_EVfB6ujQjdzBE+u=zA@mail.gmail.com>
 <CAJAp7OgfsVs9C0RNrDnQ5g7heba7JjaYFrj7wVUqT_m+wu-A3A@mail.gmail.com>
 <CAJe_ZhcSMrN6OeRjo7cG7CMobjEPMMB7o0eUD9HAFskravSQ3w@mail.gmail.com>
Message-ID: <CAJAp7OgXDYh1VEZ43UBbs8L-d2P-7ub0Yg3s73BcqC6ekzEBJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 1:01 PM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
[...]
> Mailbox isn't about how you program the h/w. Do whatever is needed to
> send a message across.
>

But there are no messages to get across here, each individual resource
is exposed directly in the address space of the Linux system.

> BTW I haven't looked closely, but probably you could push the data tables in DT?
>

The first RFC for this had all configuration in devicetree; we decided
not to go that path as this gave a cleaner abstraction and is less
error prone.

Regards,
Bjorn
