From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 6 Aug 2012 22:32:25 +0300
Subject: [PATCH 1/1] remoteproc: extend customized fw loader to cover
 request and release
In-Reply-To: <CAEvN+1h5dVxX74YtBNwjiqzZNrpK56jBw9TaJjszf_-E3DY2gw@mail.gmail.com>
References: <1344237865-32491-1-git-send-email-roylee17@gmail.com>
 <CAK=WgbbBHspN_LTUXH1kUugH8-Nr-G=p-G3Wj60tAmrqqfakmg@mail.gmail.com>
 <CAEvN+1h5dVxX74YtBNwjiqzZNrpK56jBw9TaJjszf_-E3DY2gw@mail.gmail.com>
Message-ID: <CAK=WgbbaRMf+-1cS8E+8eK-X=571-nO1ot1ywEP3=-homfMWhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy,

On Mon, Aug 6, 2012 at 7:43 PM, Tzu-Jung Lee <roylee17@gmail.com> wrote:
> That's what I'm trying to do, and it has two things needs to be address.
>
>   1)  Make the firmware loading step "optional" in the booting process.
>
>   2)  Allow the remoteproc use an customized handler to get the resource table.

Before we start digging into this, can you please tell which platform
are you working with ? is it upstream yet ?

Last we talked you couldn't yet disclose the platform identity. If
it's not upstream yet, we might prefer to postpone these discussions
until it is, to avoid unnecessary churn.

Thanks,
Ohad.
