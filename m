From: illusionist.neo@gmail.com (Shubham Bansal)
Date: Tue, 20 Jun 2017 07:04:54 +0530
Subject: [PATCH v2] arm: eBPF JIT compiler
In-Reply-To: <594813AA.5010001@iogearbox.net>
References: <1495754003-21099-1-git-send-email-illusionist.neo@gmail.com>
 <CAGXu5jKmLNMR+uhM9Ov2XPW6kCjip_SjScgEH0fTFp6fQtKFiA@mail.gmail.com>
 <593E6B0F.8070901@iogearbox.net>
 <CAHgaXd+DW2bggto=2S9hOdMrtPTvhD2QN4rPf2V8iHewQpg-YA@mail.gmail.com>
 <CAHgaXdJrvKdzr3fJ1TMkC4foeVsZJDSVEwhDOeZGxQVsmoK2cQ@mail.gmail.com>
 <59419D1E.2060303@iogearbox.net>
 <CAHgaXdKMbFPgy-kKF0iDSAYo4CqLn9FRu9HwM+OfM-JWb9fNRQ@mail.gmail.com>
 <594813AA.5010001@iogearbox.net>
Message-ID: <CAHgaXdLtX6yLdU3bMvS=g8FZ79sM_BW_+hHTMH=Mfk4TZqUnpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

>
> Sorry, had a travel over the weekend, so didn't read it in time.
>
> What is the issue with imitating in JIT what the interpreter is
> doing as a starting point? That should be generic enough to handle
> any case.
>
> Otherwise you'd need some sort of reverse mapping since verifier
> already converted BPF_CALL insns into relative helper addresses
> in imm part.
>
Sorry but I don't get what you are trying to say. Can you explain it
with an example?

-Shubham
