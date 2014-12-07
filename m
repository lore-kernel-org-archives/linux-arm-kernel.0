From: julian.calaby@gmail.com (Julian Calaby)
Date: Mon, 8 Dec 2014 10:44:40 +1100
Subject: [PATCH 0/20] fix misspelling of current function in string
In-Reply-To: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAGRGNgWDJqV=XD+6q26Ma=m1sEi1kvLWsjq6=RjRVSFTxow0Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

On Mon, Dec 8, 2014 at 6:20 AM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> These patches replace what appears to be a reference to the name of the
> current function but is misspelled in some way by either the name of the
> function itself, or by %s and then __func__ in an argument list.

Would there be any value in doing this for _all_ cases where the
function name is written in a format string?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
