From: viresh.kumar@linaro.org (viresh kumar)
Date: Fri, 13 Jul 2012 11:48:10 +0100
Subject: [PATCH V2 7/7] net: stmmac: Overwrite platform data if passed
 from auxdata
In-Reply-To: <4FFFF984.5070905@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <d72fd8775e055a0788226f1a9c1fbe3e333f6bae.1342171151.git.vipulkumar.samar@st.com>
 <CAOh2x=nn_Z6KkzW0cCtBDJnsNhAKLfEbkC0pJNK+OY9X0-XYjw@mail.gmail.com>
 <4FFFF984.5070905@st.com>
Message-ID: <CAOh2x=kM_0OSCqunh8CcbLYCqX_+Zk1RMe0WcV-AoZuTv9nT9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 11:33 AM, vipul kumar samar
<vipulkumar.samar@st.com> wrote:
> Correct me if i am wrong, We cant pass function pointer from device tree.
> For that we need to pass platdata it from auxdata_lookup.
>
> In case of stmmac, phy is configure through init function passed in platform
> data. Any other way to pass function pointer in device tree??

Hope, you have already gone through my comments for 6/7.
